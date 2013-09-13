package it.polito.ixemlabs.ixemcam.ws;

import javax.servlet.annotation.WebServlet;

import com.sun.jersey.spi.container.servlet.ServletContainer;

@WebServlet(urlPatterns = {"/rest/*"}, loadOnStartup = 1)
public class JerseyLoader extends ServletContainer {
	private static final long serialVersionUID = 1L;

}
