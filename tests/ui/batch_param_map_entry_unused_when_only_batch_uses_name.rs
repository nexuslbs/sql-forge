use sql_forge::sql_forge;

mod support;

fn main() {
    let items = vec![support::BatchIdCategory {
        id: 1i64,
        category: "Batch".to_string(),
    }];

    let _ = sql_forge!(
        "INSERT INTO products (id, category) VALUES {(:id, :category)}",
        ( :category = "TopLevel" ),
        ..items,
    );
}