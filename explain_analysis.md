# Phân Tích Hiệu Năng Truy Vấn Với EXPLAIN

- **Trước khi tối ưu:** Truy vấn sử dụng `YEAR(created_at) = 2026 AND MONTH(created_at) = 6` làm câu lệnh rơi vào trạng thái **Non-SARGable**. MySQL không thể dùng cây B-Tree Index, dẫn đến chỉ số `type = ALL` (Full Table Scan) quét toàn bộ 5 triệu dòng, làm CPU chạm mốc 100% và gây khóa tài nguyên bảng trong 45 giây.
- **Sau khi tối ưu:** Bổ sung Composite Index `idx_type_date(transaction_type, created_at)` và chuyển điều kiện thời gian sang dạng khoảng nửa mở `[2026-06-01 00:00:00, 2026-07-01 00:00:00)`.
- **Kết quả:** Kế hoạch thực thi EXPLAIN ghi nhận `type = range`, `key = idx_type_date`. MySQL chỉ duyệt trực tiếp dải nhánh cây chứa dữ liệu tháng 6/2026, loại bỏ quét toàn bảng và giảm thời gian phản hồi về mili-giây.
