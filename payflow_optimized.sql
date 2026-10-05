-- 1. Tạo database nếu chưa có và sử dụng
CREATE DATABASE IF NOT EXISTS payflow_db;
USE payflow_db;

-- 2. Xóa bảng cũ nếu tồn tại để reset sạch sẽ môi trường và index cũ
DROP TABLE IF EXISTS Transactions;

-- 3. Tạo bảng Transactions
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(15,2),
    transaction_type VARCHAR(20),
    created_at DATETIME
);

-- 4. Chèn dữ liệu mẫu để kiểm thử
INSERT INTO Transactions (user_id, amount, transaction_type, created_at) VALUES
(101, 500000.00, 'DEPOSIT', '2026-06-15 10:30:00'),
(102, 200000.00, 'WITHDRAW', '2026-06-16 11:00:00'),
(103, 1000000.00, 'DEPOSIT', '2026-06-20 14:15:00'),
(101, 350000.00, 'DEPOSIT', '2026-07-02 09:00:00');

-- 5. Tạo Composite Index tối ưu cho mệnh đề WHERE
CREATE INDEX idx_type_date ON Transactions(transaction_type, created_at);

-- 6. Truy vấn tối ưu (Chuẩn SARGable) với EXPLAIN
EXPLAIN 
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at < '2026-07-01 00:00:00';