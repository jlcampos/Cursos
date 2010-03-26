package my.god.fb;

import java.awt.AlphaComposite;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Rectangle;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.awt.image.PixelGrabber;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.io.StringBufferInputStream;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.tidy.Tidy;
import org.xhtmlrenderer.pdf.ITextRenderer;

import com.sun.pdfview.PDFFile;
import com.sun.pdfview.PDFPage;

 
public class HTML2ImageService {
 
	public void createImage(String fileName, String html, int width, int height) throws Exception {
		File file = new File(fileName);
		file.mkdirs();
    	file.createNewFile();
    	String imageName = "/image"+width + "x" + height +".png";
    	FileOutputStream ostream = new FileOutputStream(fileName + imageName);
    	convert(ostream, html, width, height);
    	ostream.close();
		
	}
	
	public void deleteImage(String fileName,int width, int height) throws Exception {
		String imageName = "/image"+width + "x" + height +".png";
		File file = new File(fileName + imageName);
		file.delete();
		file = new File(fileName);
		file.delete();		
	}
	
	public void convert(OutputStream output, String html, int width, int height) throws Exception {
	    
	    StringBuffer buf = new StringBuffer();
	    Tidy tidy = new Tidy();
	    tidy.setXHTML(true);
	    	    
	    // parse the markup into an xml Document
	    Document doc = tidy.parseDOM(new StringBufferInputStream(html), null);
	    
	    ITextRenderer renderer = new ITextRenderer();
	    renderer.setDocument(doc, null);

	    //String outputFile = "c://100bottles.pdf";
	    ByteArrayOutputStream os = new ByteArrayOutputStream();
	    renderer.layout();
	    renderer.createPDF(os);
	    
	    
        ByteBuffer buf2 = ByteBuffer.wrap(os.toByteArray());
        os.close();
        PDFFile pdffile = new PDFFile(buf2);

        // draw the first page to an image
        PDFPage page = pdffile.getPage(0);        
      //get the width and height for the doc at the default zoom 
        Rectangle rect = new Rectangle(0,0,
                (int)page.getBBox().getWidth(),
                (int)page.getBBox().getHeight());
        
      //generate the image
        Image img = page.getImage(
                rect.width, rect.height, //width & height
                rect, // clip rect
                null, // null for the ImageObserver
                true, // fill background with white
                true  // block until drawing is done
                );
        
        ImageIO.write(resize(toBufferedImage(img),width,height), "PNG", output);
	}
	

	private BufferedImage resize(BufferedImage image, int width, int height) {
		int type = image.getType() == 0? BufferedImage.TYPE_INT_ARGB : image.getType();
		BufferedImage resizedImage = new BufferedImage(width, height, type);
		Graphics2D g = resizedImage.createGraphics();
		g.setComposite(AlphaComposite.Src);

		g.setRenderingHint(RenderingHints.KEY_INTERPOLATION,
		RenderingHints.VALUE_INTERPOLATION_BILINEAR);

		g.setRenderingHint(RenderingHints.KEY_RENDERING,
		RenderingHints.VALUE_RENDER_QUALITY);

		g.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
		RenderingHints.VALUE_ANTIALIAS_ON);

		g.drawImage(image, 0, 0, width, height, null);
		g.dispose();
		return resizedImage;
		}
	
	 public BufferedImage toBufferedImage(Image image) {
         if (image instanceof BufferedImage) {
             // Return image unchanged if it is already a BufferedImage.
             return (BufferedImage) image;
         }
         
         // Ensure image is loaded.
         image = new ImageIcon(image).getImage();        
         
         int type = hasAlpha(image) ? BufferedImage.TYPE_INT_RGB : BufferedImage.TYPE_INT_ARGB;
         BufferedImage bufferedImage = new BufferedImage(image.getWidth(null), image.getHeight(null), type);
         Graphics g = bufferedImage.createGraphics();
         g.drawImage(image, 0, 0, null);
         g.dispose();
         
         return bufferedImage;
     }
	 
	 public boolean hasAlpha(Image image) {
         PixelGrabber pg = new PixelGrabber(image, 0, 0, 1, 1, false);
         try {
             pg.grabPixels();
         } catch (InterruptedException ex) { }
         return pg.getColorModel().hasAlpha();
     }
}

 
