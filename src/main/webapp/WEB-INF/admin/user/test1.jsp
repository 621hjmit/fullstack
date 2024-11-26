<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp" %>



	<!-- component container -->
	<!-- [ Main Content ] start -->
  <div class="pc-container">
    
    <div class="pc-content">
    
	   <div id="widget" style="height: calc(100% - 40px); padding: 20px 20px 0;"></div>
	</div>
	</div>
	
<script>

layout = new dhx.Layout("widget", {
    rows: [
        {
            id: "grid",
        },
        {
            height: 46,
            css: "dhx_widget--bordered",
            align: "start",
            cols: [
                {
                    id: "pagination",
                    width: "content"
                },
                {
                    id: "text",
                    width: "content",
                    padding: 12,
                },
                {
                    id: "page_size",
                    width: 200,
                    padding: 5
                }
            ]
        }
    ]
});

const grid = new dhx.Grid(null, {
    columns: [
        {
            width: 100, id: "id", header: [{ text: "#" }], template: function (value, row) {
                if (value.indexOf("u") == 0)
                    return ""
                return value

            }
        },
        { width: 200, id: "country", header: [{ text: "Country" }] },
        { width: 150, id: "population", header: [{ text: "Population" }] },
        { width: 150, id: "yearlyChange", header: [{ text: "Yearly Change" }] },
        { width: 150, id: "netChange", header: [{ text: "Net Change" }] },
        { width: 150, id: "density", header: [{ text: "Density (P/Km²)" }] },
        { width: 150, id: "area", header: [{ text: "Land Area (Km²)" }] },
        { width: 150, id: "migrants", header: [{ text: "Migrants (net)" }] },
        { width: 150, id: "fert", header: [{ text: "Fert. Rate" }] },
        { width: 150, id: "age", header: [{ text: "Med. Age" }] },
        { width: 150, id: "urban", header: [{ text: "Urban Pop" }] }
    ],
    selection: "row"
});

const lazyDataProxy = new dhx.LazyDataProxy("https://docs.dhtmlx.com/suite/backend/lazyload", {
    from: 0,
    limit: 15,
    prepare: 0,
    delay: 150
});

grid.data.load(lazyDataProxy).then(function () {
    updatePageInfo()
});

const pagination = new dhx.Pagination(null, {
    css: "dhx_widget--bordered dhx_widget--no-border_top",
    data: grid.data,
    pageSize: 15
});

const combobox = new dhx.Combobox(null, {
    readOnly: true,
    data: [
        { id: "10", value: "10 rows per page" },
        { id: "15", value: "15 rows per page" },
        { id: "20", value: "20 rows per page" },
        { id: "25", value: "25 rows per page" },
        { id: "30", value: "30 rows per page" },
        { id: "50", value: "50 rows per page" },
    ],
    value: "15"
});
combobox.events.on("change", function (id) {
    if (id) {
        var size = +id;
        const selectedCell = grid.selection.getCell();

        if (grid.data.dataProxy && grid.data.dataProxy.config)
            lazyDataProxy.updateUrl("https://docs.dhtmlx.com/suite/backend/lazyload", {
                from: grid.data.dataProxy.config.from,
                limit: size,
                prepare: 0,
                delay: 150
            });
        pagination.setPageSize(size);
        updatePageInfo()

        if (selectedCell) {
            const index = grid.data.getIndex(selectedCell.row.id);
            const page = Math.floor(index / size);
            pagination.setPage(page);
            dhx.awaitRedraw().then(() => {
                grid.scrollTo(selectedCell.row.id, "country");
            });
            grid.paint();
        }
    }

});

pagination.events.on("change", function (index, previousIndex) {
    updatePageInfo()
});

layout.getCell("pagination").attach(pagination);
layout.getCell("grid").attach(grid);
layout.getCell("page_size").attach(combobox)

function updatePageInfo() {
    layout.getCell("text").attachHTML(
        "Records from "
        + [pagination.getPage() * pagination.getPageSize() + 1]
        + " to "
        + [Math.min([pagination.getPage() + 1] * pagination.getPageSize(), grid.data.getLength())]
        + " of "
        + grid.data.getLength()
    );
}
</script>

<%@ include file="/WEB-INF/admin/common/footer.jsp" %>
