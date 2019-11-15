-- Query 1 - Copy the database.
CREATE DATABASE lab14_normal WITH TEMPLATE lab14;

-- Query 2 - Inside your copied database, create the secondary table you're splitting functionality into.
CREATE TABLE BOOKSHELVES (id SERIAL PRIMARY KEY, name VARCHAR(255));

-- Query 3 - In the name column of the bookshelves table, insert all unique values from the bookshelf column of the books table.
INSERT INTO bookshelves(name) SELECT DISTINCT bookshelf FROM books;

-- Query 4 - Add a new column to the books table called bookshelf_id, specify that it will only accept integer values.
ALTER TABLE books ADD COLUMN bookshelf_id INT;

-- Query 5 - Populate the bookshelf_id column that was just created with the id values from the bookshelves table where the bookshelf name from the books table and the name from the bookshelves table match. 
UPDATE books SET bookshelf_id=shelf.id FROM (SELECT * FROM bookshelves) AS shelf WHERE books.bookshelf = shelf.name;

-- Query 6 - Remove the now redundant bookshelf column from the books table.
ALTER TABLE books DROP COLUMN bookshelf;

-- Query 7 - In the books table specify that the bookshelf_id column is a foreign key for the bookshelves table and thus constrained by the values in the id column of the bookshelves table.
ALTER TABLE books ADD CONSTRAINT fk_bookshelves FOREIGN KEY (bookshelf_id) REFERENCES bookshelves(id);
