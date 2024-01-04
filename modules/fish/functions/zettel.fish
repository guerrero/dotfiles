function zettel --description 'Renames files by prefixing them with their creation date and a slugified version of their original names, preserving file extensions'
    # Function to remove accents and special characters
    function remove_accents
        set -l name $argv
        # Manual replacements for accented characters
        set name (string replace -ra 'á|à|ã|â|ä' 'a' $name)
        set name (string replace -ra 'é|è|ê|ë' 'e' $name)
        set name (string replace -ra 'í|ì|î|ï' 'i' $name)
        set name (string replace -ra 'ó|ò|õ|ô|ö' 'o' $name)
        set name (string replace -ra 'ú|ù|û|ü' 'u' $name)
        set name (string replace -ra 'ç' 'c' $name)
        set name (string replace -ra 'ñ' 'n' $name)

        # Replace any other non-alphanumeric characters with dashes
        set name (string replace -ra '[^a-zA-Z0-9]' '-' $name)
        echo $name
    end

    # Function to slugify filenames
    function slugify
        set -l name (echo $argv | tr '[:upper:]' '[:lower:]') # Convert to lowercase
        set -l clean_name (remove_accents $name) # Remove accents and special characters
        echo $clean_name
    end

    for filename in $argv
        # Check if file exists
        if not test -e $filename
            echo "File '$filename' not found."
            continue
        end

        # Retrieve the creation date of the file
        set creation_date (stat -f %SB -t %Y%m%d%H%M%S $filename)

        # Extract the file extension
        set extension (string match -r '\.[^.]*$' $filename)

        # Extract the filename without extension
        set name_without_ext (string replace $extension '' (basename $filename))

        # Check for existing date format and split the filename
        set date_prefix (string match -r '^\d{14}' $name_without_ext)
        set name_to_slugify $name_without_ext

        if set -q date_prefix[1]
            set name_to_slugify (string replace $date_prefix[1]_ '' $name_without_ext)
        else
            set date_prefix $creation_date
        end

        # Slugify the part of the filename that needs slugification
        set slugified_name (slugify $name_to_slugify)

        # Construct the new filename
        set new_filename "$date_prefix"_"$slugified_name"$extension

        if [ "$new_filename" != "$filename" ]
            mv $filename $new_filename
            echo "File renamed to $new_filename"
        else
            echo "File '$filename' already formatted. Skipping."
        end
    end
end