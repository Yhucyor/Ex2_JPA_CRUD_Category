<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
<%@ include file="common/sidebar.jspf" %>

<div class="main-wrapper">
    <header class="topbar">
        <div>
            <span class="topbar-label">Trang quản trị</span>
            <strong>Quản lý danh mục</strong>
        </div>
        <a href="${pageContext.request.contextPath}/admin/categories" class="topbar-action">Làm mới</a>
    </header>

    <main class="content">
        <section class="page-heading">
            <div>
                <p class="eyebrow">CRUD Category</p>
                <h1>Danh sách danh mục</h1>
                <p class="page-description">Theo dõi, tìm kiếm và thao tác nhanh với các danh mục trong hệ thống.</p>
            </div>

            <c:url value="/admin/category/add" var="addUrl"/>
            <a href="${addUrl}" class="primary-button">
                <span>+</span>
                Thêm danh mục
            </a>
        </section>

        <section class="panel">
            <div class="panel-toolbar">
                <div>
                    <h2>Bảng danh mục</h2>
                    <p><span id="visibleCount">0</span> danh mục đang hiển thị</p>
                </div>

                <label class="search-box">
                    <span>Tìm kiếm</span>
                    <input type="text" id="categorySearch" placeholder="Nhập tên danh mục..." oninput="filterCategories()">
                </label>
            </div>

            <div class="table-wrap">
                <table class="category-table" id="categoryTable">
                    <thead>
                    <tr>
                        <th>STT</th>
                        <th>Ảnh</th>
                        <th>Tên danh mục</th>
                        <th>Trạng thái</th>
                        <th>Đường dẫn ảnh</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${listcate}" var="cate" varStatus="status">
                        <tr class="category-row">
                            <td class="index-cell">${status.index + 1}</td>
                            <td>
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
                                        <img src="${imgUrl}" class="category-image" alt="${cate.categoryname}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="image-placeholder">No image</div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="category-name">
                                <strong><c:out value="${cate.categoryname}"/></strong>
                                <span>ID: ${cate.categoryid}</span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${cate.status == 1}">Hoạt động</c:when>
                                    <c:otherwise>Khóa</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="icon-path">
                                <c:choose>
                                    <c:when test="${not empty cate.images}">
                                        <c:out value="${cate.images}"/>
                                    </c:when>
                                    <c:otherwise>Chưa có ảnh</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="action-group">
                                    <c:url value="/admin/category/edit" var="editUrl">
                                        <c:param name="id" value="${cate.categoryid}"/>
                                    </c:url>
                                    <c:url value="/admin/category/delete" var="deleteUrl">
                                        <c:param name="id" value="${cate.categoryid}"/>
                                    </c:url>

                                    <a href="${editUrl}" class="icon-button edit-button" title="Sửa danh mục">Sửa</a>
                                    <a href="${deleteUrl}" class="icon-button delete-button" title="Xóa danh mục"
                                       data-delete-url="${deleteUrl}"
                                       data-category-name="<c:out value='${cate.categoryname}'/>"
                                       onclick="openDeleteModal(this); return false;">Xóa</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty listcate}">
                        <tr>
                            <td colspan="6">
                                <div class="empty-state">
                                    <strong>Chưa có danh mục nào</strong>
                                    <span>Hãy thêm danh mục đầu tiên để bắt đầu quản lý.</span>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
</div>

<div class="modal-backdrop" id="deleteModal" hidden>
    <div class="confirm-dialog" role="dialog" aria-modal="true" aria-labelledby="deleteModalTitle">
        <div class="confirm-icon">!</div>
        <h2 id="deleteModalTitle">Xác nhận xóa danh mục</h2>
        <p>
            Bạn sắp xóa danh mục
            <strong id="deleteCategoryName"></strong>.
            Thao tác này không thể hoàn tác.
        </p>
        <div class="confirm-actions">
            <button type="button" class="secondary-button" onclick="closeDeleteModal()">Hủy</button>
            <a href="#" class="danger-button" id="confirmDeleteButton">Xóa danh mục</a>
        </div>
    </div>
</div>

<script>
    const deleteModal = document.getElementById("deleteModal");
    const deleteCategoryName = document.getElementById("deleteCategoryName");
    const confirmDeleteButton = document.getElementById("confirmDeleteButton");

    function openDeleteModal(link) {
        deleteCategoryName.textContent = link.dataset.categoryName || "này";
        confirmDeleteButton.href = link.dataset.deleteUrl;
        deleteModal.hidden = false;
        document.body.classList.add("modal-open");
    }

    function closeDeleteModal() {
        deleteModal.hidden = true;
        confirmDeleteButton.href = "#";
        document.body.classList.remove("modal-open");
    }

    deleteModal.addEventListener("click", event => {
        if (event.target === deleteModal) {
            closeDeleteModal();
        }
    });

    document.addEventListener("keydown", event => {
        if (event.key === "Escape" && !deleteModal.hidden) {
            closeDeleteModal();
        }
    });

    function updateVisibleCount() {
        const rows = document.querySelectorAll(".category-row");
        const visibleRows = Array.from(rows).filter(row => row.style.display !== "none");
        document.getElementById("visibleCount").textContent = visibleRows.length;
    }

    function filterCategories() {
        const keyword = document.getElementById("categorySearch").value.toLowerCase().trim();
        const rows = document.querySelectorAll(".category-row");

        rows.forEach(row => {
            const name = row.querySelector(".category-name").textContent.toLowerCase();
            row.style.display = name.includes(keyword) ? "" : "none";
        });

        updateVisibleCount();
    }

    updateVisibleCount();
</script>
</body>
</html>
