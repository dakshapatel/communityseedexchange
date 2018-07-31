class ChangeColumnName < ActiveRecord::Migration
  def change
   change_table :seeds do |t|
     t.rename :type, :catergory

   end
 end
end
