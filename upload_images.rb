require 'aws-sdk'

$s3 = Aws::S3::Resource.new(region: 'ap-southeast-2')

dirs = %w(images stylesheets)

def upload_all_files_in(dir)
  Dir.glob(File.join(Dir.home,"projects/lpf/public/#{dir}/*")) do |local_file|
    base_name = File.basename local_file 
    file_key = "#{dir}/#{base_name}"
    puts "Uploading #{local_file} as #{file_key}"
    file_obj = $s3.bucket('lpfchocolates.com.au').object(file_key)
    puts "Got file_obj #{file_obj}"
    file_obj.upload_file local_file
    puts file_obj.public_url
  end
end

dirs.each do |dir|
  upload_all_files_in dir
end

