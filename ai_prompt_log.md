# AI Prompt Log - Kỹ Thuật Tối Ưu Index & EXPLAIN

## Prompt 1: Vấn đề Non-SARGable
- **Hỏi:** Tại sao sử dụng YEAR() và MONTH() trên cột thời gian lại khiến MySQL không thể dùng Index?
- **Trả lời:** B-Tree Index lưu giá trị thô có thứ tự. Khi bọc hàm xung quanh cột, Optimizer không thể ánh xạ ngược về vị trí nhánh cây nên buộc phải quét toàn bảng (Full Table Scan) để tính giá trị từng dòng.

## Prompt 2: Thứ tự cột trong Composite Index
- **Hỏi:** Tại sao lại đặt transaction_type trước created_at trong Index?
- **Trả lời:** Theo quy tắc tiền tố (Leftmost Prefix), cột sử dụng phép so sánh bằng (=) đứng trước giúp thu hẹp phạm vi tìm kiếm nhanh nhất trước khi quét dải khoảng (Range) trên cột thời gian.

## Prompt 3: Đọc kết quả EXPLAIN
- **Hỏi:** Chỉ số type = range và key = idx_type_date chứng minh điều gì?
- **Trả lời:** Chứng minh bộ tối ưu hóa đã sử dụng Index B-Tree để nhảy tới đầu mút thời gian và quét đúng dải bản ghi cần lấy thay vì quét toàn bộ bảng.
