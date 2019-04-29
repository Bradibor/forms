package ru.miref.forms;

import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.*;

public class Application {
    public static void main(String[] args) throws TransformerException, FileNotFoundException {
        StreamSource styleSource = new StreamSource(new File("C:\\Users\\bradi\\IdeaProjects\\forms\\src\\main\\resources\\transformer.xsl"));
        StreamSource dataSource = new StreamSource(new FileInputStream(new File("C:\\Users\\bradi\\IdeaProjects\\forms\\src\\main\\resources\\in.xml")));
        Transformer transformer = TransformerFactory.newInstance().newTransformer(styleSource);
        File temp = new File("C:\\Users\\bradi\\IdeaProjects\\forms\\src\\main\\resources\\result.html");
        OutputStream out = new FileOutputStream(temp);
        Result result = new StreamResult(out);
        InputStream is = new FileInputStream(temp);
        transformer.transform(dataSource, result);
    }
}
