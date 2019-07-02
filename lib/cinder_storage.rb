module Cinder
require "fog/openstack"

  def compute_connection
    Fog::Compute.new({ 
    :provider => '',
    :openstack_api_key => '',
    :openstack_username => '',
    :openstack_tenant => '',
    :openstack_auth_url => '',
    :openstack_project_name => '',
    :openstack_domain_name => ''
  })  
  end

  def volume_create
    begin
      compute_connection.volumes.create :size => @size, :name => @disp_name, :description => @device_prefix, :volume_type => @volume_type
    rescue Exception => e
      puts "Rescued: #{e.inspect}"
    end
  end

  def status
    if volume_create.status == "creating"
       p "Requested storage has been created"
    else
       p "Requested storage could not be created"
    end
  end

  def get_storage_object(storage_id)
      compute_connection.volumes.get storage_id
  end

  def volume_attach(storage_id)
    begin
      get_storage_object(storage_id).attach @instance_id, @device_prefix
    rescue Exception => e
      puts "Rescued: #{e.inspect}"
    end
  end

  def volume_detach
    begin
    if @instance_detachid.nil? || @storage_detachid.nil?
      puts "Nothing to detach"
    else
      get_storage_object(@storage_detachid).detach @instance_detachid, @storage_detachid
    end
    rescue Exception => e
    puts "Rescued: #{e.inspect}"
    end
  end

  def volume_destroy
    begin
    p get_storage_object(@storage_detachid).destroy
    rescue Exception => e
    p "Rescued: #{e.inspect}"
    end
  end
end
