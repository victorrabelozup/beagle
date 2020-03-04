package br.com.zup.beagle.sample.widget

import br.com.zup.beagle.annotation.RegisterWidget
import br.com.zup.beagle.widget.form.InputWidget

@RegisterWidget
class SampleTextField(val placeholder: String) : InputWidget()