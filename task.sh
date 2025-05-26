#!/bin/bash


echo "📦 Creating full backup of ShopDB..."
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --databases ShopDB > ShopDB_full.sql

# Відновлення у ShopDBReserve
echo "♻️ Restoring backup to ShopDBReserve..."
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < ShopDB_full.sql

# Створити дамп тільки даних ➜ для ShopDBDevelopment
echo "📦 Exporting data (no schema) from ShopDB..."
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-info > ShopDB_data_only.sql

echo "⬇️ Importing data to ShopDBDevelopment..."
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < ShopDB_data_only.sql
