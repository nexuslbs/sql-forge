use sql_forge::sql_forge;

mod support;

fn main() {
    let items = vec![support::BatchName {
        name: "Batch A".to_string(),
    }];

    let _ = sql_forge!(
        r#"INSERT INTO products (name) VALUES {("abc)}")}"#,
        ..items,
    );
}