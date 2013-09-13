package it.polito.ixemlabs.ixemcam.ws.endpoint;

import it.polito.ixemlabs.ixemcam.PropertyManager;

import java.io.File;
import java.io.FileInputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.Arrays;
import java.util.Comparator;

import javax.imageio.ImageIO;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;
import javax.ws.rs.core.Response.Status;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Path("/ap")
public class AccessPointEndPoint {

	public static final Logger logger = LoggerFactory
			.getLogger(AccessPointEndPoint.class);
	
	@GET
	@Path("/{apID}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getSensors(@PathParam("apID") long apID) {
		ResponseBuilder rb;

		try {
			JSONObject sensor1 = new JSONObject();
			sensor1.put("id", 1);
			sensor1.put("name", "Cam1");
			sensor1.put("status", "ok");
			sensor1.put("apSignal", 5);
			sensor1.put("sensorSignal", 5);

			JSONObject sensor2 = new JSONObject();
			sensor2.put("id", 2);
			sensor2.put("name", "Cam2");
			sensor2.put("status", "sleep");
			sensor2.put("apSignal", 3);
			sensor2.put("sensorSignal", 5);
			
			JSONObject json = new JSONObject();
			json.put("id", apID);
			json.accumulate("sensors", sensor1);
			json.accumulate("sensors", sensor2);

			rb = Response.status(Status.OK).entity(json.toString(4));
		} catch (JSONException e) {
			rb = Response.status(Status.INTERNAL_SERVER_ERROR).entity(
					e.getMessage());
		}

		return rb.build();
	}
	
	private File[] getImages(long sensorID) {
		String photosDirName = PropertyManager.getProperty("photos.dir");
		if (photosDirName == null)
			throw new NullPointerException(
					"property photos.dir must not be null null");

		File photosDir = new File(photosDirName, "" + sensorID);
		if (!photosDir.isDirectory())
			throw new NullPointerException(
					"photos directory does not exist or is not a directory");

		File[] photos = photosDir.listFiles(new FilenameFilter() {

			@Override
			public boolean accept(File dir, String name) {
				if (name.endsWith(".jpg") || name.endsWith(".JPG")
						|| name.endsWith(".jpeg") || name.endsWith(".JPEG"))
					return true;
				return false;
			}
		});
		logger.debug("found " + photos.length + " JPEG photos in folder...");

		Arrays.sort(photos, new Comparator<File>() {

			@Override
			public int compare(File o1, File o2) {
				return Long.valueOf(o2.lastModified()).compareTo(
						o1.lastModified());
			}
		});

		return photos;
	}

	@GET
	@Path("/{apID}/{sensorID}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getSensor(@PathParam("sensorID") long sensorID) {
		ResponseBuilder rb;

		File[] photos = this.getImages(sensorID);

		try {
			JSONObject json = new JSONObject();
			json.put("id", sensorID);
			json.put("name", "Cam" + sensorID);
			for (File file : photos) {
				json.accumulate("timestamps", file.lastModified());
			}

			rb = Response.status(Status.OK).entity(json.toString(4));
		} catch (JSONException e) {
			e.printStackTrace();
			rb = Response.status(Status.INTERNAL_SERVER_ERROR).entity(
					e.getMessage());
		}

		return rb.build();
	}

	@GET
	@Path("/{apID}/{sensorID}/{timestamp}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getSensorData(@PathParam("sensorID") long sensorID,
			@PathParam("timestamp") long timestamp) {
		ResponseBuilder rb = Response.status(Status.PRECONDITION_FAILED);

		String temperature = PropertyManager.getProperty("temperature");
		String humidity = PropertyManager.getProperty("humidity");
		
		File[] photos = this.getImages(sensorID);
		for (File photo : photos) {
			if (photo.lastModified() == timestamp) {
				try {
					JSONObject json = new JSONObject();
					json.put("photo", photo.getName());
					json.put("temperature", temperature);
					json.put("humidity", humidity);

					rb = Response.status(Status.OK).entity(json.toString(4));
				} catch (JSONException e) {
					rb = Response.status(Status.INTERNAL_SERVER_ERROR);
				}
				break;
			}
		}

		return rb.build();
	}

	@GET
	@Path("/{apID}/{sensorID}/{timestamp}/photo")
	@Produces("image/jpeg")
	public Response getSensorDataImage(@PathParam("sensorID") long sensorID,
			@PathParam("timestamp") long timestamp) {
		ResponseBuilder rb = Response.status(Status.PRECONDITION_FAILED);

		File[] photos = this.getImages(sensorID);
		for (File photo : photos) {
			if (photo.lastModified() == timestamp) {
				try {
					rb = Response.status(Status.OK).entity(
							ImageIO.read(new FileInputStream(photo)));
				} catch (IOException e) {
					rb = Response.status(Status.INTERNAL_SERVER_ERROR);
				}
			}
		}
		return rb.build();
	}
}
