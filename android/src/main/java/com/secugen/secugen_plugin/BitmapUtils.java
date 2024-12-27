package com.secugen.secugen_plugin;

import android.graphics.Bitmap;
import android.content.Context;
import android.util.Log;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class BitmapUtils {

    public static String saveBitmapToInternalStorage(Context context, Bitmap bitmap, String fileName) {
        // Get the app's internal storage directory
        File baseDir = context.getFilesDir();

        // Create a File object referencing the subdirectory and fileName
        File file = new File(baseDir, fileName);

        try {
            // Ensure the parent directories exist
            File parentDir = file.getParentFile();
            if (parentDir != null && !parentDir.exists()) {
                boolean created = parentDir.mkdirs();
                if (!created && !parentDir.exists()) {
                    // If directory creation fails and it doesn't exist, we can't save the file
                    Log.e("BitmapUtils", "Failed to create directory: " + parentDir.getAbsolutePath());
                    return null;
                }
            }

            // Open a FileOutputStream to write the PNG image to the file
            FileOutputStream fos = new FileOutputStream(file);

            // Compress the Bitmap to PNG format and write it to the file
            boolean isSaved = bitmap.compress(Bitmap.CompressFormat.PNG, 100, fos);

            // Close the output stream
            fos.close();

            // Return the file path if saving was successful
            return isSaved ? file.getAbsolutePath() : null;

        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
