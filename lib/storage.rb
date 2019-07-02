module StorageCinder
  class Storage

    def initialize
      puts "Enter the 1:Display_name,2:Size,3:device_prefix,4:Volume_type,5:Instance_id"
      arg = gets.strip
      @disp_name,@size,@device_prefix,@volume_type,@instance_id = arg.split(",")
      puts "Enter the 1:Instance_id,2:storage_id to be detached and destory the detached storage.Keep it as {nil,nil} if no nothing to be detached or destroyed"
      arg1 = gets.strip
      @instance_detachid,@storage_detachid = arg1.split(",")
    load File.join("/Users/srn001g/Desktop/component/storage/libraries", "cinder_storage.rb")
    end
  end
end

#call out the actions 
storage_main = StorageCinder::Storage.new
storage_main.extend Cinder

#create storage
obj = storage_main.volume_create

#storage creation status 
storage_main.status

#get the Storage_ID
storage_id = obj.id

#Attach storage to an instance
storage_main.volume_attach(storage_id)

#Detach storage from an instance
storage_main.volume_detach

#Destroy storage from an instance
storage_main.volume_destroy
