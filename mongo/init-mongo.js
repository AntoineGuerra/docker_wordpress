db.createUser(
    {
        user: "tct",
        password: "tagada",
        roles : [
            {
                role: "readWrite",
                db: "tct_db",
            },
        ],
    }
);
