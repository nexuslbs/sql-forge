use sql_forge::sql_forge;

mod support;

fn main() {
    let _ = sql_forge!(
        sqlx::Postgres,
        support::TransparentId,
        "SELECT id FROM users LIMIT 1",
    );
}