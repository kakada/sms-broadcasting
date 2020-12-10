class BroadcastsController < ApplicationController
  before_action :authenticate_user!

  def index
    @broadcasts = Broadcast.all
  end

  def new
  end

  def create
    if file_params[:file].present?
      Tester.transaction do
        broadcast = Broadcast.create

        csv_file = file_params[:file]
        csv_importer = TesterCsvImporter.new broadcast
        csv_importer.import(csv_file)
      end

      redirect_to broadcasts_path, notice: "Broadcast has successfully imported"
    else
      redirect_to new_broadcast_path, warning: "Please select .csv file"
    end
  end

  private
    def file_params
      params.require(:broadcasts).permit(:file)
    end
end
