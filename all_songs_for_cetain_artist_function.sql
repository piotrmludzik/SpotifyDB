-- 4. Funkcja zwracająca dla danego artysty nazwy wszystkich użytkowników,
-- którzy mają jego piosenki na playliście

CREATE OR REPLACE FUNCTION get_users_by_artist_on_playlist(id_num int)
    RETURNS TABLE (id int, name CHAR(150), email CHAR(150), premium BOOLEAN)
    language plpgsql
    AS
    $$
        BEGIN
            RETURN QUERY
            SELECT "user".id, "user".name, "user".email, "user".premium FROM "user"
            LEFT JOIN user_playlist up ON "user".id = up.user_id
            LEFT JOIN playlist p on up.playlist_id = p.id
            LEFT JOIN song s on p.song_id = s.id
            LEFT JOIN song_artist sa on s.id = sa.song_id
            WHERE artist_id = id_num;
        END;
    $$;

SELECT * FROM  get_users_by_artist_on_playlist(1000);