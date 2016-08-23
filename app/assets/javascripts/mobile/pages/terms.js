/**
 * Created by Chris on 3/30/2016.
 */
accordian_panels = document.getElementById("accordion").getElementsByClassName('panel');

Array.prototype.forEach.call(accordian_panels, function (panel) {
    panel.getElementsByClassName('accordion-toggle')[0].onclick = function () {

        var panel_body = panel.getElementsByClassName("panel-collapse")[0];

        if (hasClass(panel_body, 'in')) {
            panel_body.classList.remove('in');
            this.classList.add('collapsed');
        }
        else {
            panel_body.classList.add('in');
            this.classList.remove('collapsed');
        }

    }
});