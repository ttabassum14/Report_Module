package com.primebank.servlet.report;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

class HeaderFooter extends PdfPageEventHelper {
    private Font headerFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
    private Font footerFont = new Font(Font.FontFamily.HELVETICA, 8, Font.ITALIC);
    private Phrase header = new Phrase("Prime Bank Limited - Confidential Report", headerFont);
    private Phrase footer = new Phrase("© 2025 Prime Bank Limited | www.primebank.com.bd", footerFont);

    @Override
    public void onEndPage(PdfWriter writer, Document document) {
        PdfContentByte cb = writer.getDirectContent();

        // Header
        ColumnText.showTextAligned(cb, Element.ALIGN_CENTER,
                header,
                (document.right() + document.left()) / 2,
                document.top() + 20, 0);

        // Footer
        ColumnText.showTextAligned(cb, Element.ALIGN_CENTER,
                footer,
                (document.right() + document.left()) / 2,
                document.bottom() - 20, 0);
    }
}
