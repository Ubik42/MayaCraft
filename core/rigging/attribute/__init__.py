# core/rigging/attribute/__init__.py
# -*- coding: utf-8 -*-

from .twist_bendy import TwistBendyAttribute
from .inbetween import InbetweenAttribute
from .seg_scale_comp import SegScaleCompAttribute
from .global_attribute import GlobalOrientAttribute
from .aim import AimAttribute

# Manual Registration
_ATTRIBUTES = {
    "twist/bendy": TwistBendyAttribute,
    "inbetween": InbetweenAttribute,
    "segScaleComp": SegScaleCompAttribute,
    "global":GlobalOrientAttribute,
    "aim":AimAttribute
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
