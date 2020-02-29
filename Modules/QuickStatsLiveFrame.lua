local AceGUI = LibStub("AceGUI-3.0")

QuickStatsLiveFrame = {}
function QuickStatsLiveFrame:Create()
	local frame = AceGUI:Create("QSLDialogBox")

	local label = AceGUI:Create("Label")
	label:SetFont("Fonts\\FRIZQT__.ttf", 12)
	frame:AddChild(label)

	local this = {}
	this._frame = frame
	this._label = label

	function this:ReDraw(inputMap)
		local count, width = 1, 1
		local frame = self._frame
		local label = self._label
		local str = ""
		
		for idx, text in next, inputMap do
			count = count + 1
			str = str .. "\n" .. text
			width = math.max(width, strlen(text))
		end
		
		label:SetText(str)
		
		local height = label.label:GetHeight()
		local width = label.label:GetStringWidth()
		frame:SetHeight(height + 2)
		frame:SetWidth(width + 10)
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

	return this
end
