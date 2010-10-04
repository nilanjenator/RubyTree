# binarytree.rb - This file is part of the RubyTree package.
#
# $Revision$ by $Author$ on $Date$
#
# = binarytree.rb - An implementation of the binary tree data structure.
#
# Provides a binary tree data structure with ability to
# store two node elements as children at each node in the tree.
#
# Author:: Anupam Sengupta (anupamsg@gmail.com)
#

# Copyright (c) 2007, 2008, 2009, 2010 Anupam Sengupta
#
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
# - Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# - Redistributions in binary form must reproduce the above copyright notice, this
#   list of conditions and the following disclaimer in the documentation and/or
#   other materials provided with the distribution.
#
# - Neither the name of the organization nor the names of its contributors may
#   be used to endorse or promote products derived from this software without
#   specific prior written permission.
#
#   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

require 'tree'

module Tree

  # Provides a Binary tree implementation. This node allows only two child nodes (left and right child).  It also
  # provides direct access to the left or right child, including assignment to the same.
  #
  # This inherits from the {Tree::TreeNode} class.
  #
  # @author Anupam Sengupta
  #
  class BinaryTreeNode < TreeNode

    # Adds the specified child node to the receiver node.  The child node's parent is set to be the receiver.
    #
    # The child nodes are added in the order of addition, i.e., the first child added becomes the left node, and the
    # second child added will be the second node.
    #
    # If only one child is present, then this will be the left child.
    #
    # @param [Tree::BinaryTreeNode] child The child to add.
    #
    # @raise [ArgumentError] This exception is raised if two children are already present.
    def add(child)
      raise ArgumentError, "Already has two child nodes" if @children.size == 2

      super(child)
    end

    # Returns the left child of the receiver node. Note that left Child == first Child.
    #
    # @return [Tree::BinaryTreeNode] The left most (or first) child.
    #
    # @see #right_child
    def left_child
      children[0]
    end

    # Returns the right child of the receiver node. Note that right child == last child unless there is only one child.
    #
    # Returns +nil+ if the right child does not exist.
    #
    # @return [Tree::BinaryTreeNode] The right child, or +nil+ if the right side child does not exist.
    #
    # @see #left_child
    def right_child
      children[1]
    end

    # A protected method to allow insertion of child nodes at the specified location.
    # Note that this method allows insertion of +nil+ nodes.
    #
    # @param [Tree::BinaryTreeNode] child The child to add at the specified location.
    # @param [Integer] at_index The location to add the entry at (0 or 1).
    #
    # @return [Tree::BinaryTreeNode] The added child.
    #
    # @raise [ArgumentError] If the index is out of limits.
    def set_child_at(child, at_index)
      raise ArgumentError "A binary tree cannot have more than two children." unless (0..1).include? at_index

      @children[at_index]        = child
      @children_hash[child.name] = child if child # Assign the name mapping
      child.parent               = self if child
      child
    end

    # Sets the left child of the receiver node. If a previous child existed, it is replaced.
    #
    # Note that #children.size will return 2 if either #left_child= or
    # #right_child= methods are invoked.  This allows +nil+ to be
    # assigned to any of the children while retaining the correct
    # count of the children.
    #
    # @param [Tree::BinaryTreeNode]
    # child The child to add as the left-side node.
    #
    # @return [Tree::BinaryTreeNode] The assigned child node.
    #
    # @see #left_child
    # @see #right_child=
    def left_child=(child)
      set_child_at child, 0
    end

    # Sets the right child of the receiver node. If a previous child existed, it is replaced.
    #
    # Note that #children.size will return 2 if either #left_child= or
    # #right_child= methods are invoked.  This allows +nil+ to be
    # assigned to any of the children while retaining the correct
    # count of the children.
    #
    # @param [Tree::BinaryTreeNode] child The child to add as the right-side node.
    #
    # @return [Tree::BinaryTreeNode] The assigned child node.
    #
    # @see #right_child
    # @see #left_child=
    def right_child=(child)
      set_child_at child, 1
    end

    # Returns +true+ if the receiver node is the left child of its parent.
    # Always returns +false+ if it is a root node.
    #
    # @return [Boolean] +true+ if this is the left child of its parent.
    def is_left_child?
      return false if is_root?
      self == parent.left_child
    end

    # Returns +true+ if the receiver node is the right child of its parent.
    # Always returns +false+ if it is a root node.
    #
    # @return [Boolean] +true+ if this is the right child of its parent.
    def is_right_child?
      return false if is_root?
      self == parent.right_child
    end

    # Traverses the (sub)tree rooted at the receiver node in in-ordered sequence.
    #
    # @yield [child] Each child is passed to the block.
    #
    # @yieldparam [Tree::TreeNode] node Each node.
    #
    # @see #preordered_each
    # @see #postordered_each
    def inordered_each &block
      left_child.inordered_each(&block) if left_child
      yield self
      right_child.inordered_each(&block) if right_child
    end

    # Swaps the left and right child nodes of the receiver node with each other.
    #
    # @todo Define the return value.
    def swap_children
      self.left_child, self.right_child = self.right_child, self.left_child
    end

    protected :set_child_at

  end

end
