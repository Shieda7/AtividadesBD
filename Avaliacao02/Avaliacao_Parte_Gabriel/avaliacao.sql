-- Desativa temporariamente verificações de chaves únicas e estrangeiras para facilitar a criação das tabelas.
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Criação do schema 'mydb' para o banco de dados, que agrupa as tabelas.
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- Criação da tabela 'membro' que armazena as informações dos membros da biblioteca.
CREATE TABLE IF NOT EXISTS `mydb`.`membro` (
  `id_domembro` INT NOT NULL,                -- Identificador único do membro (chave primária).
  `nome` VARCHAR(45) NULL,                   -- Nome do membro.
  `endereco` VARCHAR(45) NULL,               -- Endereço do membro (corrigido de 'enderco' para 'endereco').
  `telefone` INT NOT NULL,                   -- Telefone do membro.
  `data_deassociacao` DATE NULL,             -- Data em que o membro se associou à biblioteca.
  PRIMARY KEY (`id_domembro`)                -- Chave primária da tabela.
)
ENGINE = InnoDB;                             -- O motor de armazenamento InnoDB garante a integridade referencial e suporte a transações.

-- Criação da tabela 'livro' que armazena as informações dos livros disponíveis na biblioteca.
CREATE TABLE IF NOT EXISTS `mydb`.`livro` (
  `id_dolivro` INT NOT NULL,                 -- Identificador único do livro (chave primária).
  `titulo` VARCHAR(90) NULL,                 -- Título do livro.
  `autor` VARCHAR(45) NULL,                  -- Autor do livro.
  `ano_publicado` DATE NULL,                 -- Ano de publicação do livro.
  `genero` VARCHAR(45) NULL,                 -- Gênero do livro (ex: Ficção, História, etc.).
  PRIMARY KEY (`id_dolivro`)                 -- Chave primária da tabela.
)
ENGINE = InnoDB;                             -- O motor de armazenamento InnoDB.

-- Criação da tabela 'emprestimo' que registra os empréstimos realizados pelos membros.
CREATE TABLE IF NOT EXISTS `mydb`.`emprestimo` (
  `id_doemprestimo` INT NOT NULL,            -- Identificador único do empréstimo (chave primária).
  `id_dolivro` INT NOT NULL,                 -- Chave estrangeira que referencia o livro emprestado.
  `id_domembro` INT NOT NULL,                -- Chave estrangeira que referencia o membro que fez o empréstimo.
  `data_deemprestimo` DATE NULL,             -- Data em que o empréstimo foi realizado.
  `data_dedevolucao` DATE NULL,              -- Data de devolução do livro.
  PRIMARY KEY (`id_doemprestimo`),           -- Chave primária composta por ID do empréstimo.
  FOREIGN KEY (`id_dolivro`) REFERENCES `mydb`.`livro` (`id_dolivro`),  -- Chave estrangeira que referencia a tabela 'livro'.
  FOREIGN KEY (`id_domembro`) REFERENCES `mydb`.`membro` (`id_domembro`) -- Chave estrangeira que referencia a tabela 'membro'.
)
ENGINE = InnoDB;

-- Restaura as configurações de chaves únicas, estrangeiras e modo SQL ao estado anterior.
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
