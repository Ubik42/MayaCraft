# core/rigging/attribute/__init__.py
# -*- coding: utf-8 -*-

from .twist import TwistAttribute
from .bendy import BendyAttribute
from .inbetween import InbetweenAttribute
from .seg_scale_comp import SegScaleCompAttribute

# Manual Registration
_ATTRIBUTES = {
    "twist": TwistAttribute,
    "bendy": BendyAttribute,
    "inbetween": InbetweenAttribute,
    "segScaleComp": SegScaleCompAttribute
}

def get_all_slot_names():
    """
    Returns list of attribute names for the UI list.
    """
    return list(_ATTRIBUTES.keys())

def get_attribute_class(name):
    """
    Returns the attribute class for a given name.
    """
    return _ATTRIBUTES.get(name)

def create_attribute(label_type, builder, mapping_data):
    """
    Factory: Create attribute instance from label type.
    """
    attr_class = _ATTRIBUTES.get(label_type)
    if attr_class:
        return attr_class(builder, mapping_data)
    else:
        # Not a registered attribute class (maybe a regular module?)
        return None
