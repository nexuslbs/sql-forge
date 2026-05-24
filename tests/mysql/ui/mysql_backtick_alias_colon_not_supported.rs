use sql_forge::sql_forge;

fn main() {
    #[derive(sqlx::FromRow)]
    struct Row {
        my_field: i64,
    }

    let _ = sql_forge!(
        Row,
        "SELECT 1 AS `my_field:String`",
    );
}