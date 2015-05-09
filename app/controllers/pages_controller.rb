class PagesController < ApplicationController

	def welcome
		render("welcome.html.erb")
	end

	def calculator
		target_calc = params[:the_calc]
		render target_calc
	end

	def calculator_results

		if params[:the_calc] == "tempdiv"

			chan_length = params[:chan_length].to_f
			chan_width = params[:chan_width].to_f
			chan_incline_left = params[:chan_incline_left].to_f
			chan_incline_right = params[:chan_incline_right].to_f
			chan_total_width = params[:chan_total_width].to_f
			silt_fence_depth = params[:silt_fence_depth].to_f
			length_roll_bedding = params[:length_roll_bedding].to_f

			@num_rolls = ( chan_length / length_roll_bedding ).ceil
			@bed_length = chan_length + 3 * ( @num_rolls - 1 )
			atangent = Math.atan(chan_incline_right/chan_incline_left)
			cos = Math.cos(atangent)
			bed_width_total = (chan_width+((chan_total_width-chan_width)/cos)+4*silt_fence_depth)
			@bed_width = bed_width_total.round(1)
			@bed_area = ( @bed_length * bed_width_total ).round(1)
			@chan_vol = 0.5 * ((chan_total_width - chan_width)/2) * (chan_incline_right/chan_incline_left)
			
			render 'tempdiv_results'

		elsif params[:the_calc] == "log_vanes"

			qfc_width = params[:qfc_width].to_f
			angle_shore = params[:angle_shore].to_f
			qfc_log_takes = params[:qfc_log_takes].to_f
			into_bank = params[:into_bank].to_f

			radians = ( angle_shore / 180 ) * Math::PI
			sine_radians = Math.sin(radians)

			@log_len = ( qfc_log_takes * qfc_width + into_bank ) / sine_radians

			render'log_vanes_results'

		elsif params[:the_calc] == "jhook_vanes"

			qfc_width = params[:qfc_width].to_f
			angle_shore = params[:angle_shore].to_f
			rock_width = params[:rock_width].to_f
			rock_height = params[:rock_height].to_f
			rock_diameter = params[:rock_diameter].to_f
			gap_fraction = params[:gap_fraction].to_f
			rock_tiers = params[:rock_tiers].to_f

			radians = ( angle_shore / 180 ) * Math::PI
			sine_radians = Math.sin(radians)
			jhook_length = (( ( qfc_width / 3 ) / sine_radians ) + (qfc_width / 3))
			jhook_gap_volume = ( (qfc_width/3) / ( 1/gap_fraction +1) )
			jhook_total_volume = jhook_length * rock_width * rock_height * rock_tiers - jhook_gap_volume

			@jhook_length = jhook_length.round(1)
			@jhook_gap_volume = jhook_gap_volume.round(1)
			@jhook_total_volume = jhook_total_volume.round(1)

			render 'jhook_vanes_results'

		elsif params[:the_calc] == "rock_vanes"

			qcf_width = params[:qcf_width].to_f
			angle_shore = params[:angle_shore].to_f
			fraction_qcf_takes = params[:fraction_qcf_takes].to_f
			rock_height = params[:rock_height].to_f
			rock_width = params[:rock_width].to_f

			radians = ( angle_shore / 180 ) * Math::PI
			sine_radians = Math.sin(radians)
			rock_vanes_length = ( qcf_width * fraction_qcf_takes ) / sine_radians
			rock_vanes_volume = rock_height * rock_width * rock_vanes_length

			@rock_vanes_length = rock_vanes_length.round(1)
			@rock_vanes_volume = rock_vanes_volume.round(1)

			render 'rock_vanes_results'

		end

	end

end