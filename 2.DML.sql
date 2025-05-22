-- insert : 테이블에 데이터 삽입
insert into 테이블명(컬럼1, 컬럼2, 컬럼3) values(데이터1, 데이터2, 데이터3);
insert into author(id, name, email) values(2, 'hong2', 'hong2@naver.com');

-- update : 테이블에 데이터 변경
update author set name='홍길동', email='hong@naver.com' where id=2;

-- select : 조회
select 컬럼1, 컬럼2 from 테이블명;
select name, email from author;

-- delete : 삭제
delete from 테이블명 where 조건절;
delete from author where id = 3;

-- select 조건절 활용 조회
-- 테스트 데이터 삽입 : insert문을 활용해서 author 데이터 3개, post데이터 5개
select * from author; -- 어떤 조회조건없이 모든 컬럼 조회
select * from author where id=1;
select * from author where name='hongildong';
select * from author where id>3;
select * from author where id>3 and name='kim';

-- 중복제거 조회 : distinct
select name from author;
select distinct name from author;

-- 정렬 : order by + 컬럼명
-- asc : 오름차순, desc : 내림차순, 기본값은 asc
-- 아무런 정렬조건 없이 조회할 경우에는 pk기준으로 오름차순
select * from author order by name;

-- 멀티 컬럼 order by : 여러컬럼으로 정렬시에, 먼저 쓴 컬럼 우선정렬. 중복시, 정렬 옵션 적용
-- (외워야 된다)
select * from author order by name desc, email asc; -- name으로 먼저 정렬 후, name이 중복되면 email로 정렬.

-- 결과값 개수 제한
select * from author order by id desc limit 1;

-- 별칭(alias)를 이용한 select
select name as '이름', email as '이메일' from author;
select a.name, a.email from author as a;
select a.name, a.email from author a;

-- null을 조회조건으로 활용 (null타입만 =가 아닌 is를 사용한다)
select * from author where age is null;
select * from author where age is not null;

-- 프로그래머스 sql 문제풀이
-- 1. 여러 기준으로 정렬하기 (https://school.programmers.co.kr/learn/courses/30/lessons/59404)
-- 2. 상위 n개 레코드 (https://school.programmers.co.kr/learn/courses/30/lessons/59405)