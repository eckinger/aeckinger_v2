-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE photos (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    date TEXT NOT NULL,
    caption TEXT NOT NULL,
    photo_url TEXT DEFAULT NULL
);
