--
-- 2. Widok ze wszystkimi informacjami o piosenkach danego artysty

CREATE OR REPLACE VIEW artist_view AS
    SELECT song.name, song.date, song.duration, artist.id FROM song
    LEFT JOIN song_artist ON song.id = song_artist.song_id
    LEFT JOIN artist ON artist.id = song_artist.artist_id;

CREATE OR REPLACE FUNCTION get_artist_songs(id_num int)
    RETURNS TABLE(name_var CHAR(150), data_var DATE, duration_var DOUBLE PRECISION)
    AS
    $$
    BEGIN
        RETURN QUERY
        SELECT name, date, duration FROM artist_view WHERE id = id_num;
    END;
    $$ language plpgsql;

SELECT get_artist_songs(1000);