local AceGUI = LibStub("AceGUI-3.0")

QuickStatsLiveFrame = {}
function QuickStatsLiveFrame:Create()
	local frame = AceGUI:Create("QSLDialogBox")

	local label = AceGUI:Create("Label")
	label:SetFont(STANDARD_TEXT_FONT, 12)
	label:SetRelativeWidth(1)
	frame:AddChild(label)

	local this = {}
	this._frame = frame
	this._label = label

	function this:ReDraw(inputMap)
		local frame = self._frame
		local label = self._label
		local str = ""
		
		for idx, text in next, inputMap do
			str = str .. "\n" .. text
		end
		
		label:SetText(str)
		
		local height = label.label:GetHeight()
		local width = label.label:GetStringWidth()
		frame:SetHeight(height)
		frame:SetWidth(width + 5)
	end

	function this:Hide()
		self._frame:Hide()
	end

	function this:Show()
		self._frame:Show()
	end

	function this:SetMovable(mv)
		self._frame:EnableMovable(mv)
	end

	function this:ColorizeText(r, g, b)
		self._label:SetColor(r, g, b)
	end

	function this:ColorizeBackdrop(r, g, b, a)
		self._frame:SetBackdropColor(0, 0, 0, a)
	end

    function this:SetFont(name, size)
        self._label:SetFont(name, size)
    end

	return this
end
