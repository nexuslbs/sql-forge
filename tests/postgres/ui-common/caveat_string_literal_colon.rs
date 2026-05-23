use sql_forge::sql_forge;

mod support;

fn main() {
    let _ = sql_forge!(
        sqlx::Postgres,
        support::User,
        r#"SELECT id, name FROM users WHERE name = "abc:def""#,
    );
}