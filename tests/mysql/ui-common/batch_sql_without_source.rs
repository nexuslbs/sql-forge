use sql_forge::sql_forge;

fn main() {
    let _ = sql_forge!(
        "INSERT INTO products (name, price, stock, category) VALUES {(:name, :price, 1, 'BatchError')}",
    );
}