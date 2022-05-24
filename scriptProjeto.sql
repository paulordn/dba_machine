/* Comandos Select*/
select * from BKP_USUARIO.LOG_USUARIO;

SELECT * FROM USUARIOS;

DESC USUARIOS;

USE usuario;





/*Criação da DATABASE de usuarios*/

CREATE DATABASE usuario;

use usuario;

/* Criando Tabela Usuarios*/

CREATE TABLE USUARIOS (
idUsuario INT NOT NULL auto_increment primary key,
nome VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL UNIQUE,
senha VARCHAR(30) NOT NULL,
CPF CHAR(11) NOT NULL UNIQUE,
ADM boolean NOT NULL,
DATANASC date NOT NULL
);

/*Inserção de dados mockados na tabela usuários*/

INSERT INTO USUARIOS VALUES(NULL, 'JACQUE', 'JACQUE@GMAIL.COM', 'JACQUE123', '19758367580', true, '1990-06-21');
INSERT INTO USUARIOS VALUES(NULL, 'JAC', 'JAC@GMAIL.COM', 'JACE123', '40089223403', false, '1980-07-12');
INSERT INTO USUARIOS VALUES(NULL, 'MARCOS', 'MARCOS@GMAIL.COM', 'MARCOS123', '40089223486', true, '1990-04-17');
INSERT INTO USUARIOS VALUES(NULL, 'NATALI123', 'NATALI1A@GMAIL.COM', 'NATALIA123', '40089223678', false, '1980-07-12');

/*Criação da DATABASE de Backup*/

CREATE DATABASE BKP_USUARIO;

use BKP_USUARIO;

/*Criando a tabela de LOG do usuário*/

CREATE TABLE LOG_USUARIO(
idBackup INT PRIMARY KEY auto_increment,
idUsuario INT,
nome_anterior VARCHAR(50),
nome_atual VARCHAR(50),
email_anterior VARCHAR(50),
email_atual VARCHAR(50),
senha_anterior VARCHAR(30),
senha_atual VARCHAR(30),
CPF_anterior CHAR(11),
CPF_atual CHAR(11),
ADM_anterior boolean,
ADM_atual boolean,
DATANASC_anterior date,
DATANASC_atual date,
Data_de_modificacao DATETIME,
USUARIO VARCHAR(30),
EVENTO CHAR(1)
);

/* Criando Triggers */

USE usuario;


 /* Trigger de Update */

DELIMITER $
CREATE TRIGGER tr_update
AFTER UPDATE ON USUARIOS
for each row
begin

       INSERT INTO BKP_USUARIO.LOG_USUARIO VALUES(NULL,OLD.idUsuario,OLD.nome,NEW.nome,OLD.email,
       NEW.email,OLD.senha,NEW.senha,OLD.CPF,NEW.CPF,OLD.ADM,NEW.ADM,OLD.DATANASC,NEW.DATANASC,
       now(), current_user(), 'U');
end
$


DELIMITER ;

UPDATE USUARIOS  
SET senha= '1234'
WHERE idUsuario = 4;


 /* Trigger de Insert */

DELIMITER $
CREATE TRIGGER tr_insert
AFTER INSERT ON USUARIOS
for each row
begin

       INSERT INTO BKP_USUARIO.LOG_USUARIO VALUES(NULL,NEW.idUsuario,NULL,NEW.nome,NULL,
       NEW.email,NULL,NEW.senha,NULL,NEW.CPF,NULL,NEW.ADM,NULL,NEW.DATANASC,
       now(), current_user(), 'I');
end
$

DELIMITER ;

INSERT INTO USUARIOS VALUES(NULL, 'PEDRO', 'PEDRO@GMAIL.COM', 'PEDRO123', '12378690643', true, '1978-09-12');

 /* Trigger Delete */

DELIMITER $
CREATE TRIGGER tr_delete
BEFORE DELETE ON USUARIOS
for each row
begin

       INSERT INTO BKP_USUARIO.LOG_USUARIO VALUES(NULL,OLD.idUsuario,OLD.nome,NULL,OLD.email,
       NULL,OLD.senha,NULL,OLD.CPF,NULL,OLD.ADM,NULL,OLD.DATANASC,NULL,
       now(), current_user(), 'D');
end
$
DELIMITER ;


DELETE FROM USUARIOS 
WHERE idUsuario = 2;



           /* Selects para uma melhor visualização de o que cada trigger alterou/deletou/inseriu*/
		   
/* Select das Trigger Update */
SELECT nome_anterior,nome_atual, email_anterior,email_atual,senha_anterior, senha_atual,CPF_anterior, CPF_atual, ADM_anterior, ADM_atual,
 DATANASC_anterior, DATANASC_atual,Data_de_modificacao, USUARIO, EVENTO
FROM BKP_USUARIO.LOG_USUARIO
WHERE EVENTO = 'U';

/*Select das Triggers Delete */
SELECT nome_anterior, email_anterior, senha_anterior, CPF_anterior, ADM_anterior, DATANASC_anterior, Data_de_modificacao, USUARIO, EVENTO
FROM BKP_USUARIO.LOG_USUARIO
WHERE EVENTO = 'D';

/* Select das Triggers Insert */
SELECT nome_atual, email_atual, senha_atual, CPF_atual, ADM_atual , DATANASC_atual, Data_de_modificacao, USUARIO, EVENTO
FROM BKP_USUARIO.LOG_USUARIO
WHERE EVENTO = 'I';

/* Dados para teste */
INSERT INTO USUARIOS VALUES(NULL, 'thiago', 'thiago@GMAIL.COM', 'thiago123', '12378690553', TRUE, '1978-09-12');

INSERT INTO USUARIOS VALUES(NULL, 'matheus', 'MATHEUS@GMAIL.COM', 'MATHEUS123', '12378690553', TRUE, '1978-09-12');

INSERT INTO USUARIOS VALUES(NULL, 'paulo', 'paulo@GMAIL.COM', 'paulo123', '12378690553', TRUE, '1978-09-12');


USE usuario;

CREATE TABLE IF NOT EXISTS Maquinas(
id INTEGER NOT NULL auto_increment ,
rotacao INTEGER NOT NULL,
temperatura INTEGER NOT NULL,
avanco INTEGER NOT NULL,
datahora VARCHAR(255) NOT NULL,
PRIMARY KEY (id)
);

SELECT * FROM Maquinas;