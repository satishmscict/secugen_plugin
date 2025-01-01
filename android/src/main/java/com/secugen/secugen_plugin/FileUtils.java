package com.secugen.secugen_plugin;

import android.content.Context;
import android.graphics.Bitmap;
import android.util.Log;

import androidx.annotation.NonNull;

import java.io.File;

public class FileUtils {

    public static boolean deleteSubdirectory(Context context, @NonNull String folderName) {
        File folderToDelete = new File(context.getFilesDir(), folderName);
        return deleteDirectoryRecursively(folderToDelete);
    }

    /**
     * Recursively deletes the specified directory and all contents.
     *
     * @param directory the directory to delete
     * @return true if all contents including the directory were deleted successfully;
     *         false if any file or directory deletion failed.
     */
    private static boolean deleteDirectoryRecursively(@NonNull File directory) {
        if (!directory.exists()) {
            // Directory does not exist, so there's nothing to delete. Consider this a success.
            return true;
        }

        if (directory.isFile()) {
            // If it's a file, just delete it directly.
            return directory.delete();
        }

        // If directory is actually a folder, iterate contents.
        File[] children = directory.listFiles();
        if (children == null) {
            // listFiles() can return null if an I/O error occurs.
            return false;
        }

        boolean success = true;
        for (File child : children) {
            // Recursively delete each child (which might be a file or folder).
            if (!deleteDirectoryRecursively(child)) {
                success = false;
            }
        }

        // Finally, delete this folder after its contents have been removed.
        return success && directory.delete();
    }

    public static boolean clearAllFiles(@NonNull Context context,String directoryName) {
        boolean isDeleted = deleteSubdirectory(context, directoryName);
        if (isDeleted) {
            Log.d("DeleteDir", "Successfully deleted "+ directoryName +" directory.");
        } else {
            Log.e("DeleteDir", "Failed to delete some or all contents of xyz directory.");
        }

        // Return whether all files were successfully deleted
        return isDeleted;
    }
}
