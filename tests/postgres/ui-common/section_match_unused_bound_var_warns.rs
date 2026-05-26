#![deny(unused_variables)]

use sql_forge::sql_forge;

mod support;

fn main() {
    let limit = Some(1i64);
    let _ = sql_forge!(
        support::User,
        "SELECT id, name FROM users WHERE 1=1 {#filter_limit} ORDER BY id",
        (
            #filter_limit = match limit {
                Some(limit) => "",  // `limit` bound but NOT used in params (SQL is "")
                None => "",
            },
        )
    );
}
