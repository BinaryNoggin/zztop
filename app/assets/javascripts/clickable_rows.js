// Make rows in Clients table take you to Clients#show.
jQuery(document).ready(function($) {
    $("table#users tr").click(function() {
        window.document.location = $(this).find(".last_name a").attr("href");
    });
});
