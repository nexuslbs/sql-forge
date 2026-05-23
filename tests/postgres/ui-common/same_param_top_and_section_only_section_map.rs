use sql_forge::sql_forge;

mod support;

fn main() {
    let _ = sql_forge!(
        sqlx::Postgres,
        support::User,
        "SELECT id, name FROM users WHERE id >= :id {#filter}",
        (
            #filter = (
                " AND id <= :id ",
                ( :id = 10i64 ),
            ),
        ),
    );
}