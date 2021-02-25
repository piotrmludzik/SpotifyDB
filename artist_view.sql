--
-- 2. Widok ze wszystkimi informacjami o piosenkach danego artysty


CREATE OR REPLACE VIEW artist_view AS
    SELECT song.name, song.date, song.duration, artist.id FROM song
    LEFT JOIN song_artist ON song.id = song_artist.song_id
    LEFT JOIN artist ON artist.id = song_artist.artist_id;

CREATE OR REPLACE FUNCTION get_artist_songs(id_num int)
    RETURNS TABLE(i int)
    AS
    $$
    BEGIN
        SELECT name, date, duration FROM artist_view WHERE id = $1;
    END;
    $$ language plpgsql;

SELECT get_artist_songs(1000);