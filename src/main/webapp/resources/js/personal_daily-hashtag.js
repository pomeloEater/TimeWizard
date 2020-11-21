function placeCaretAtEnd(el) {
    el.focus();
    if (typeof window.getSelection != "undefined" && typeof document.createRange != "undefined") {
        var range = document.createRange();
        range.selectNodeContents(el);
        range.collapse(false);
        var sel = window.getSelection();
        sel.removeAllRanges();
        sel.addRange(range);
    } else if (typeof document.body.createTextRange != "undefined") {
        var textRange = document.body.createTextRange();
        textRange.moveToElementText(el);
        textRange.collapse(false);
        textRange.select();
    }
}

// closes the span housing the hashtag
function closeSpan() {
    var span = document.createElement("span");
    span.setAttribute("data-role", "remove");
    span.setAttribute("class", "delHashtag");
    span.setAttribute("aria-hidden", "true");
    return span;
}

$(document).ready(function() {
    var hashtags = false;

    $(document).on('keypress', '.todo__editable', function(e) {
        var input_field = $(this);
        var x = e.which || e.keyCode;
        if (x == 32) { // space key
            if (hashtags) {
                e.preventDefault();
                input_field.html(input_field.html() + "</span>&nbsp;");
                placeCaretAtEnd(this);
                hashtags = false;
                document.getElementsByClassName("new")[0].setAttribute("contenteditable", false);
                document.getElementsByClassName("new")[0].appendChild(closeSpan());
            }
        }
        if (x == 35) { // hash key (#)
            e.preventDefault();
            $(".tag").removeClass("new");
            input_field.html(input_field.html() + "<span class='tag label label-info new'>#");
            placeCaretAtEnd(this);
            hashtags = true;
        }
        // various punctuation characters
        if (x == 8 || x == 9 || x >= 16 && x <= 18 || x == 27 || x == 33 || x == 34 || x >= 36 && x <= 47 || x >= 58 && x <= 64 || x >= 91 && x <= 94 || x == 96 || x >= 123 && x <= 126) {
            if (hashtags) {
                e.preventDefault();
                input_field.html(input_field.html() + "</span>" + String.fromCharCode(x));
                placeCaretAtEnd(this);
                hashtags = false;
                document.getElementsByClassName("new")[0].setAttribute("contenteditable", false);
                document.getElementsByClassName("new")[0].appendChild(closeSpan());
            }
        }
        if (x == 13) { // return key
            document.execCommand('defaultParagraphSeparator', false, 'p');
        }

    });

    $(document).on("click", ".delHashtag", function() {
        this.parentNode.parentNode.removeChild(this.parentNode);
        return false;
    });
});