class DocumentsController < ApplicationController
	def index
		@documents = Document.all
	end

	def destroy
		@document = Document.find(params[:id])
		@document.destroy
	end
end
