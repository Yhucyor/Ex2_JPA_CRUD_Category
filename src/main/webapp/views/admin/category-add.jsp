<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm danh mục</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
<%@ include file="common/sidebar.jspf" %>

<div class="main-wrapper">
    <header class="topbar">
        <div>
            <span class="topbar-label">Biểu mẫu</span>
            <strong>Thêm danh mục</strong>
        </div>
        <a href="${pageContext.request.contextPath}/admin/categories" class="topbar-action">Danh sách</a>
    </header>

    <main class="content">
        <section class="page-heading compact-heading">
            <div>
                <p class="eyebrow">Category</p>
                <h1>Tạo danh mục mới</h1>
                <p class="page-description">Nhập tên danh mục, đường dẫn ảnh hoặc tải ảnh đại diện từ máy.</p>
            </div>
        </section>

        <section class="panel form-panel">
            <form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data" class="category-form">
                <div class="form-grid">
                    <label class="form-field">
                        <span>Tên danh mục</span>
                        <input type="text" id="categoryname" name="categoryname" placeholder="Ví dụ: Âm nhạc, Thể thao..." required autofocus>
                    </label>

                    <label class="form-field">
                        <span>Link ảnh</span>
                        <input type="text" id="images" name="images" placeholder="https://...">
                    </label>

                    <label class="form-field">
                        <span>Upload ảnh</span>
                        <input type="file" id="images1" name="images1" accept="image/png,image/jpeg,image/webp">
                    </label>

                    <div class="form-field">
                        <span>Trạng thái</span>
                        <label class="radio-line">
                            <input type="radio" id="ston" name="status" value="1" checked>
                            Hoạt động
                        </label>
                        <label class="radio-line">
                            <input type="radio" id="stoff" name="status" value="0">
                            Khóa
                        </label>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="primary-button">Thêm danh mục</button>
                    <button type="reset" class="secondary-button">Nhập lại</button>
                    <a href="${pageContext.request.contextPath}/admin/categories" class="text-button">Quay lại</a>
                </div>
            </form>
        </section>
    </main>
</div>
</body>
</html>
