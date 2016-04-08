class CreateCameraEvents < ActiveRecord::Migration
  def change
    create_table :camera_events do |t|

      t.timestamps null: false
    end
  end
end
