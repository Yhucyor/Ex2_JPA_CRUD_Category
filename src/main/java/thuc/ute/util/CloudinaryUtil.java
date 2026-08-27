package thuc.ute.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import jakarta.servlet.http.Part;

public class CloudinaryUtil {
    private static final Cloudinary cloudinary;

    static {
        Map<String, String> config = new HashMap<>();
        config.put("cloud_name", "gnht4fer");
        config.put("api_key", "997495484919781");
        config.put("api_secret", "Z6y76Ybd8vwWrOiOzbMXrnH_JOs");

        cloudinary = new Cloudinary(config);
    }

    private CloudinaryUtil() {
    }

    public static Cloudinary getCloudinary() {
        return cloudinary;
    }

    public static String uploadImage(Part filePart, String folder) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        try (InputStream inputStream = filePart.getInputStream()) {
            byte[] fileBytes = inputStream.readAllBytes();

            Map<?, ?> uploadResult = cloudinary.uploader().upload(
                    fileBytes,
                    ObjectUtils.asMap("folder", folder)
            );

            Object secureUrl = uploadResult.get("secure_url");
            return secureUrl == null ? null : secureUrl.toString();
        }
    }
}
