-- Tabel: genre
CREATE TABLE genre (
    genre_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT 'Unikaalne identifikaator igale žanrile. INT UNSIGNED pakub piisavat vahemikku unikaalsete ID-de jaoks.',
    genre_name VARCHAR(100) NOT NULL UNIQUE COMMENT 'Žanri nimi, maksimaalselt 100 märki. NOT NULL tagab, et igal žanril on nimi, ja UNIQUE välistab dubleerimised.'
);

-- Tabel: movie
CREATE TABLE movie (
    movie_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT 'Unikaalne identifikaator igale filmile. INT UNSIGNED on sobiv, kuna see pakub laia vahemikku unikaalseid ID-sid.',
    title VARCHAR(255) NOT NULL COMMENT 'Filmi pealkiri, maksimaalselt 255 märki. NOT NULL tagab, et igal filmil on pealkiri.',
    description TEXT COMMENT 'Filmi üksikasjalik kirjeldus. TEXT võimaldab pikki kirjeldusi.',
    release_date DATE COMMENT 'Filmi ilmumiskuupäev. DATE salvestab ainult kuupäeva väärtuse.',
    duration_minutes SMALLINT UNSIGNED COMMENT 'Filmi kestus minutites. Väärtused vahemikus 0 kuni 65,535.',
    genre_id INT UNSIGNED NOT NULL COMMENT 'Võõrvõti, mis viitab tabelile genre. INT UNSIGNED tagab järjepidevuse genre_id-ga.',
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id) ON DELETE CASCADE
);

-- Tabel: user
CREATE TABLE user (
    user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT 'Unikaalne identifikaator igale kasutajale. INT UNSIGNED pakub piisavat vahemikku unikaalsete ID-de jaoks.',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT 'Unikaalne kasutajanimi, maksimaalselt 50 märki. NOT NULL tagab, et igal kasutajal on kasutajanimi, ja UNIQUE välistab dubleerimised.',
    email VARCHAR(255) NOT NULL UNIQUE COMMENT 'Kasutaja e-posti aadress, unikaalne ja maksimaalselt 255 märki. NOT NULL tagab, et igal kasutajal on e-post.',
    password_hash VARCHAR(255) NOT NULL COMMENT 'Krüpteeritud parool turvalisuse tagamiseks. VARCHAR(255) on piisav krüpteeritud paroolide jaoks.',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Aeg, millal kasutaja loodi. DATETIME salvestab nii kuupäeva kui ka aja.'
);

-- Tabel: watch_history
CREATE TABLE watch_history (
    history_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT 'Unikaalne identifikaator igale vaatamisajaloo kirjele. INT UNSIGNED pakub piisavat vahemikku unikaalsete ID-de jaoks.',
    user_id INT UNSIGNED NOT NULL COMMENT 'Võõrvõti, mis viitab tabelile user. NOT NULL tagab, et iga ajaloo kirje on seotud kasutajaga.',
    movie_id INT UNSIGNED NOT NULL COMMENT 'Võõrvõti, mis viitab tabelile movie. NOT NULL tagab, et iga ajaloo kirje on seotud filmiga.',
    watched_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Aeg, millal filmi vaadati. DATETIME salvestab nii kuupäeva kui ka aja.',
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id) ON DELETE CASCADE
);

-- Tabel: rating
CREATE TABLE rating (
    rating_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT 'Unikaalne identifikaator igale hinnangule. INT UNSIGNED pakub piisavat vahemikku unikaalsete ID-de jaoks.',
    user_id INT UNSIGNED NOT NULL COMMENT 'Võõrvõti, mis viitab tabelile user. NOT NULL tagab, et iga hinnang on seotud kasutajaga.',
    movie_id INT UNSIGNED NOT NULL COMMENT 'Võõrvõti, mis viitab tabelile movie. NOT NULL tagab, et iga hinnang on seotud filmiga.',
    rating TINYINT UNSIGNED NOT NULL COMMENT 'Kasutaja antud hinnang, vahemikus 1 kuni 5.',
    review TEXT COMMENT 'Valikuline ülevaade filmi kohta. TEXT võimaldab kasutajatel kirjutada detailseid ülevaateid.',
    rated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Aeg, millal hinnang esitati. DATETIME salvestab nii kuupäeva kui ka aja.',
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id) ON DELETE CASCADE
);

-- Tabel: recommendation
CREATE TABLE recommendation (
    recommendation_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT 'Unikaalne identifikaator igale soovitusele. INT UNSIGNED pakub piisavat vahemikku unikaalsete ID-de jaoks.',
    user_id INT UNSIGNED NOT NULL COMMENT 'Võõrvõti, mis viitab tabelile user. NOT NULL tagab, et iga soovitus on seotud kasutajaga.',
    movie_id INT UNSIGNED NOT NULL COMMENT 'Võõrvõti, mis viitab tabelile movie. NOT NULL tagab, et iga soovitus on seotud filmiga.',
    recommended_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Aeg, millal soovitus loodi. DATETIME salvestab nii kuupäeva kui ka aja.',
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id) ON DELETE CASCADE
);
