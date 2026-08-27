<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa danh mục</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
<%@ include file="common/sidebar.jspf" %>

<div class="main-wrapper">
    <header class="topbar">
        <div>
            <span class="topbar-label">Biểu mẫu</span>
            <strong>Chỉnh sửa danh mục</strong>
        </div>
        <a href="${pageContext.request.contextPath}/admin/categories" class="topbar-action">Danh sách</a>
    </header>

    <main class="content">
        <section class="page-heading compact-heading">
            <div>
                <p class="eyebrow">Category #${cate.categoryid}</p>
                <h1>Cập nhật danh mục</h1>
                <p class="page-description">Chỉnh sửa tên, ảnh hoặc trạng thái của danh mục đang chọn.</p>
            </div>
        </section>

        <section class="panel form-panel">
            <div class="current-category">
                <c:choose>
                    <c:when test="${not empty cate.images}">
                        <c:choose>
                            <c:when test="${cate.images.length() >= 5 && cate.images.substring(0,5) == 'https'}">
                                <c:url value="${cate.images}" var="imgUrl"/>
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image" var="imgUrl">
                                    <c:param name="fname" value="${cate.images}"/>
                                </c:url>
                            </c:otherwise>
                        </c:choose>
                        <img src="${imgUrl}" class="preview-image" alt="${cate.categoryname}">
                    </c:when>
                    <c:otherwise>
                        <div class="preview-placeholder">No image</div>
                    </c:otherwise>
                </c:choose>

                <div>
                    <span>Đang chỉnh sửa</span>
                    <strong><c:out value="${cate.categoryname}"/></strong>
                </div>
            </div>

            <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data" class="category-form">
                <input type="hidden" name="categoryid" value="${cate.categoryid}">

                <div class="form-grid">
                    <label class="form-field">
                        <span>Tên danh mục</span>
                        <input type="text" id="categoryname" name="categoryname" value="${cate.categoryname}" required autofocus>
                    </label>

                    <label class="form-field">
                        <span>Link ảnh</span>
                        <input type="text" id="images" name="images" value="${cate.images}">
                    </label>

                    <label class="form-field">
                        <span>Upload ảnh mới</span>
                        <input type="file" id="images1" name="images1" accept="image/png,image/jpeg,image/webp">
                    </label>

                    <div class="form-field">
                        <span>Trạng thái</span>
                        <label class="radio-line">
                            <input type="radio" id="ston" name="status" value="1" ${cate.status == 1 ? 'checked' : ''}>
                            Hoạt động
                        </label>
                        <label class="radio-line">
                            <input type="radio" id="stoff" name="status" value="0" ${cate.status != 1 ? 'checked' : ''}>
                            Khóa
                        </label>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="primary-button">Lưu thay đổi</button>
                    <button type="reset" class="secondary-button">Khôi phục</button>
                    <a href="${pageContext.request.contextPath}/admin/categories" class="text-button">Quay lại</a>
                </div>
            </form>
        </section>
    </main>
</div>
</body>
</html>
