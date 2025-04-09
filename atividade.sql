/*
Questão 1. Gere uma lista de todos os instrutores, mostrando sua ID, nome e número de seções que eles ministraram. 
Não se esqueça de mostrar o número de seções como 0 para os instrutores que não ministraram qualquer seção. Sua consulta deverá utilizar outer join e não deverá utilizar subconsultas escalares.
*/

select instructor.ID, instructor.name, count(teaches.sec_id) as num_sections from instructor left outer join teaches on teaches.ID = instructor.ID group by instructor.id, instructor.name;

/*
Questão 2. Escreva a mesma consulta do item anterior, mas usando uma subconsulta escalar, sem outer join.
*/

select instructor.ID, instructor.name, count(teaches.sec_id) as num_sections from instructor left join teaches on teaches.ID = instructor.ID group by instructor.id, instructor.name;

/*
Questão 3. Gere a lista de todas as seções de curso oferecidas na primavera de 2010, junto com o nome dos instrutores ministrando a seção. 
Se uma seção tiver mais de 1 instrutor, ela deverá aparecer uma vez no resultado para cada instrutor. Se não tiver instrutor algum, ela ainda deverá aparecer no resultado, com o nome do instrutor definido como “-”.
*/

select teaches.course_id, teaches.sec_id, instructor.id as ID, teaches.semester, teaches.year, case when instructor.name is null then '-' else instructor.name end as instrutor from instructor right join teaches on instructor.ID = teaches.ID where teaches.semester = 'Spring' and teaches.year = 2010 order by teaches.course_id asc;
/*
Questão 4. Suponha que você tenha recebido uma relação grade_points (grade, points), que oferece uma conversão de conceitos (letras) na relação takes para notas numéricas; por exemplo, 
uma nota “A+” poderia ser especificada para corresponder a 4 pontos, um “A” para 3,7 pontos, e “A-” para 3,4, e “B+” para 3,1 pontos, e assim por diante. 
Os Pontos totais obtidos por um aluno para uma oferta de curso (section) são definidos como o número de créditos para o curso multiplicado pelos pontos numéricos para a nota que o aluno recebeu.
Dada essa relação e o nosso esquema university, escreva: 
Ache os pontos totais recebidos por aluno, para todos os cursos realizados por ele.
*/
select student.id, student.name, course.title, department.dept_name, course.credits, student.tot_cred from student join takes on student.id = takes.id join course ON takes.course_id = course.course_id join department on course.dept_name = department.dept_name;
SELECT student.ID, SUM(course.credits * grade_points.points) AS total_de_pontos
FROM student
JOIN takes ON student.ID = takes.ID
JOIN course ON takes.course_id = course.course_id
JOIN grade_points ON takes.grade = grade_points.grade
GROUP BY student.ID;
/* 
Questão 5. Crie uma view a partir do resultado da Questão 4 com o nome “coeficiente_rendimento”.
*/
create view coeficiente_rendimento as select student.id, student.name, course.title, department.dept_name, course.credits, grade_points.grade, grade_points.points, grade_points.points *  course.credits as total_de_pontos from student inner join takes ON student.id = takes.id inner join course ON takes.course_id = course.course_id inner join department on course.dept_name = department.dept_name; inner join grade_points on takes.grade = grade_points.grade group by student.id, student.name, course.title, department.dept_name, course.credits, grade_points.grade, grade_points.points;
