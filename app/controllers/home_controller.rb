class HomeController <ApplicationController
  def index
    @warehouse = Warehouse.all
    @supplier = Supplier.all 
  end
end