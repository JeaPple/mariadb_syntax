-- tinyint : -128 ~ 127까지 표현
-- author 테이블에 age컬럼 변경
alter table author modify column age tinyint unsigned;

-- int : 4바이트(대략, 40억 숫자범위)

-- bitint : 8바이트
-- author, post테이블의 id값 bigint변경
alter table author modify column id bitint;

-- decimal(총자리수, 소수부자리수)
alter table post add column price decimal(10,3);
-- decimal 소수점 초과시 짤림현상발생
insert into post(id, title, price, author_id) 
        values(7, 'hello python', 10.33412, 1);

-- 문자타입 : 고정길이(char), 가변길이(varchar, text)
alter table author add column gender char(1);
alter table author add column self_introduction text;

-- blob(바이너리 데이터) 타입 실습
-- 일반적으로 blob으로 저장하기 보다, varchar로 설계하고 이미지경로만을 저장함.
alter table author add column profile_image longblob;
insert into author(id, email, profile_image) values (8, 'aaa@naver.com', LOAD_FILE('/Users/hyungkey/Pictures/ND1.jpg'));

-- enum : 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입
-- default 옵션으로 값을 지정하지 않을 시 기본값을 넣어준다.
-- role 컬럼 추가
alter table author add column role enum('admin','user') not null default 'user';
-- enum에 지정된 값이 아닌 경우
insert into author(id, email, role) values(9, '9@naver.com', 'admin2');
-- role을 지정 안 한 경우
insert into author(id, email, role) values(10, '10@naver.com');
-- enum에 지정된 값인 경우
insert into author(id, email, role) values(11, '11@naver.com', 'admin');

-- date와 datetime
-- 날짜타입의 입력, 수정, 조회시에 문자열 형식을 사용 (구조화된 형식)
-- ? varchar를 쓰면 되는거 아니야? -> 구조화된 형식으로 에러를 잡고, 필터를 손쉽게 사용가능.
alter table author add column birthday date;
alter table post add column created_time datetime;
insert into post(id, title, author_id, created_time)
        values(8, 'aa', 3, '2025-05-23 14:36:30');
alter table post add column created_time datetime default current_timestamp();
insert into post(id, title, author_id, created_time)
        values(9, 'aaa', 3);

-- 비교연산자
select * from author where id >=2 and id <=4; -- 2, 3, 4
select * from author where id between 2 and 4; -- 위 구문과 같으나, 헷갈리기에 잘 사용하지 않음.
select * from author where id in(2, 3, 4);

-- like : 특정 문자를 포함하는 데이터를 조회하기 위한 키워드
select * from post where title like '%a';
select * from post where title like 'a%';
select * from post where title like '%a%'; -- a가 포함된 행을 찾는다.

-- regexp : 정규표현식을 활용한 조회
select * from post where title regexp '[a-z]'; -- 하나라도 알파벳 소문자가 들어있으면
select * from post where title regexp '[가-힣]'; -- 하나라도 한글이 있으면

-- cast
-- 숫자 -> 날짜
select cast(20250523 as date); -- 2025-05-23
-- 문자 -> 날짜
select cast('20250523' as date); -- 2025-05-23
-- 문자 -> 숫자
select cast('12' as unsigned); -- unsigned는 숫자 타입, int는 지원 안 하는 경우 있음.
-- cast 활용 예시 (보통 실무보단 코테에서 많이 사용)
select * from post where cast(date_format(created_time, '%m') as unsigned) = 05;

-- 실무에서 많이 사용되는 날짜 조회.
-- 날짜조회 방법 : 2025-05-23 14:10:23
-- like 패턴, 부등호 활용, date_format
select * from post where created_time like '2025-05%'; -- 문자열처럼 조회
-- 강사님 제일 많이 사용.
-- 5월 1일부터 5월 20일까지, 날짜만 입력시 시간부분은 00:00:00이 자동으로 붙음.
select * from post where created_time >= '2025-05-01' and created_time < '2025-05-21'; 

select date_format(created_time, '%Y-%m-%d') from post;
select date_format(created_time, '%H:%i:%s') from post;
select * from post where date_format(created_time, '%m') = '05'; -- 특정 년,월,일,시간을 포맷팅할 수 있다.

-- now() : 현재시간을 출력하는 함수.
select now();