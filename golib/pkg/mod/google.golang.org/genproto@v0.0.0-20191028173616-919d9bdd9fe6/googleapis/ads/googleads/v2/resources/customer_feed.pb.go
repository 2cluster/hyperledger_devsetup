// Code generated by protoc-gen-go. DO NOT EDIT.
// source: google/ads/googleads/v2/resources/customer_feed.proto

package resources

import (
	fmt "fmt"
	math "math"

	proto "github.com/golang/protobuf/proto"
	wrappers "github.com/golang/protobuf/ptypes/wrappers"
	common "google.golang.org/genproto/googleapis/ads/googleads/v2/common"
	enums "google.golang.org/genproto/googleapis/ads/googleads/v2/enums"
	_ "google.golang.org/genproto/googleapis/api/annotations"
)

// Reference imports to suppress errors if they are not otherwise used.
var _ = proto.Marshal
var _ = fmt.Errorf
var _ = math.Inf

// This is a compile-time assertion to ensure that this generated file
// is compatible with the proto package it is being compiled against.
// A compilation error at this line likely means your copy of the
// proto package needs to be updated.
const _ = proto.ProtoPackageIsVersion3 // please upgrade the proto package

// A customer feed.
type CustomerFeed struct {
	// The resource name of the customer feed.
	// Customer feed resource names have the form:
	//
	// `customers/{customer_id}/customerFeeds/{feed_id}`
	ResourceName string `protobuf:"bytes,1,opt,name=resource_name,json=resourceName,proto3" json:"resource_name,omitempty"`
	// The feed being linked to the customer.
	Feed *wrappers.StringValue `protobuf:"bytes,2,opt,name=feed,proto3" json:"feed,omitempty"`
	// Indicates which placeholder types the feed may populate under the connected
	// customer. Required.
	PlaceholderTypes []enums.PlaceholderTypeEnum_PlaceholderType `protobuf:"varint,3,rep,packed,name=placeholder_types,json=placeholderTypes,proto3,enum=google.ads.googleads.v2.enums.PlaceholderTypeEnum_PlaceholderType" json:"placeholder_types,omitempty"`
	// Matching function associated with the CustomerFeed.
	// The matching function is used to filter the set of feed items selected.
	// Required.
	MatchingFunction *common.MatchingFunction `protobuf:"bytes,4,opt,name=matching_function,json=matchingFunction,proto3" json:"matching_function,omitempty"`
	// Status of the customer feed.
	// This field is read-only.
	Status               enums.FeedLinkStatusEnum_FeedLinkStatus `protobuf:"varint,5,opt,name=status,proto3,enum=google.ads.googleads.v2.enums.FeedLinkStatusEnum_FeedLinkStatus" json:"status,omitempty"`
	XXX_NoUnkeyedLiteral struct{}                                `json:"-"`
	XXX_unrecognized     []byte                                  `json:"-"`
	XXX_sizecache        int32                                   `json:"-"`
}

func (m *CustomerFeed) Reset()         { *m = CustomerFeed{} }
func (m *CustomerFeed) String() string { return proto.CompactTextString(m) }
func (*CustomerFeed) ProtoMessage()    {}
func (*CustomerFeed) Descriptor() ([]byte, []int) {
	return fileDescriptor_cd7590a7bcbec413, []int{0}
}

func (m *CustomerFeed) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_CustomerFeed.Unmarshal(m, b)
}
func (m *CustomerFeed) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_CustomerFeed.Marshal(b, m, deterministic)
}
func (m *CustomerFeed) XXX_Merge(src proto.Message) {
	xxx_messageInfo_CustomerFeed.Merge(m, src)
}
func (m *CustomerFeed) XXX_Size() int {
	return xxx_messageInfo_CustomerFeed.Size(m)
}
func (m *CustomerFeed) XXX_DiscardUnknown() {
	xxx_messageInfo_CustomerFeed.DiscardUnknown(m)
}

var xxx_messageInfo_CustomerFeed proto.InternalMessageInfo

func (m *CustomerFeed) GetResourceName() string {
	if m != nil {
		return m.ResourceName
	}
	return ""
}

func (m *CustomerFeed) GetFeed() *wrappers.StringValue {
	if m != nil {
		return m.Feed
	}
	return nil
}

func (m *CustomerFeed) GetPlaceholderTypes() []enums.PlaceholderTypeEnum_PlaceholderType {
	if m != nil {
		return m.PlaceholderTypes
	}
	return nil
}

func (m *CustomerFeed) GetMatchingFunction() *common.MatchingFunction {
	if m != nil {
		return m.MatchingFunction
	}
	return nil
}

func (m *CustomerFeed) GetStatus() enums.FeedLinkStatusEnum_FeedLinkStatus {
	if m != nil {
		return m.Status
	}
	return enums.FeedLinkStatusEnum_UNSPECIFIED
}

func init() {
	proto.RegisterType((*CustomerFeed)(nil), "google.ads.googleads.v2.resources.CustomerFeed")
}

func init() {
	proto.RegisterFile("google/ads/googleads/v2/resources/customer_feed.proto", fileDescriptor_cd7590a7bcbec413)
}

var fileDescriptor_cd7590a7bcbec413 = []byte{
	// 472 bytes of a gzipped FileDescriptorProto
	0x1f, 0x8b, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xff, 0x8c, 0x53, 0xdd, 0x6a, 0xd4, 0x40,
	0x14, 0x26, 0xbb, 0xb5, 0x60, 0xac, 0xa5, 0x9b, 0xab, 0x50, 0x8a, 0x6c, 0x95, 0xc2, 0x5e, 0xcd,
	0x94, 0xf8, 0x73, 0x11, 0x6f, 0xcc, 0x8a, 0x2d, 0x88, 0xca, 0x92, 0xca, 0x22, 0xb2, 0x12, 0xa6,
	0xc9, 0xd9, 0x34, 0x34, 0xf3, 0xc3, 0xcc, 0xa4, 0xd2, 0xa7, 0xf0, 0x1d, 0xbc, 0xf4, 0x51, 0x7c,
	0x14, 0x1f, 0x42, 0x24, 0x99, 0x99, 0x68, 0x57, 0x62, 0xbd, 0x3b, 0x39, 0xf3, 0x7d, 0x5f, 0xbe,
	0x73, 0xbe, 0x19, 0xff, 0x69, 0xc9, 0x79, 0x59, 0x03, 0x26, 0x85, 0xc2, 0xa6, 0x6c, 0xab, 0xab,
	0x08, 0x4b, 0x50, 0xbc, 0x91, 0x39, 0x28, 0x9c, 0x37, 0x4a, 0x73, 0x0a, 0x32, 0x5b, 0x03, 0x14,
	0x48, 0x48, 0xae, 0x79, 0x70, 0x68, 0xb0, 0x88, 0x14, 0x0a, 0xf5, 0x34, 0x74, 0x15, 0xa1, 0x9e,
	0xb6, 0xff, 0x6c, 0x48, 0x39, 0xe7, 0x94, 0x72, 0x86, 0x29, 0xd1, 0xf9, 0x45, 0xc5, 0xca, 0x6c,
	0xdd, 0xb0, 0x5c, 0x57, 0x9c, 0x19, 0xe9, 0xfd, 0x27, 0x43, 0x3c, 0x60, 0x0d, 0x55, 0xb8, 0x35,
	0x91, 0xd5, 0x15, 0xbb, 0xcc, 0x94, 0x26, 0xba, 0x51, 0xff, 0xc7, 0x12, 0x35, 0xc9, 0xe1, 0x82,
	0xd7, 0x05, 0xc8, 0x4c, 0x5f, 0x0b, 0xb0, 0xac, 0x07, 0x96, 0xd5, 0x7d, 0x9d, 0x37, 0x6b, 0xfc,
	0x59, 0x12, 0x21, 0x40, 0x3a, 0xd5, 0x03, 0xa7, 0x2a, 0x2a, 0x4c, 0x18, 0xe3, 0x9a, 0xb4, 0x46,
	0xed, 0xe9, 0xc3, 0x2f, 0x63, 0x7f, 0xe7, 0xa5, 0x5d, 0xce, 0x09, 0x40, 0x11, 0x3c, 0xf2, 0xef,
	0xbb, 0xf9, 0x33, 0x46, 0x28, 0x84, 0xde, 0xd4, 0x9b, 0xdd, 0x4d, 0x77, 0x5c, 0xf3, 0x1d, 0xa1,
	0x10, 0x1c, 0xfb, 0x5b, 0xed, 0x0c, 0xe1, 0x68, 0xea, 0xcd, 0xee, 0x45, 0x07, 0x76, 0x7d, 0xc8,
	0x59, 0x40, 0x67, 0x5a, 0x56, 0xac, 0x5c, 0x92, 0xba, 0x81, 0xb4, 0x43, 0x06, 0xdc, 0x9f, 0x6c,
	0xfa, 0x57, 0xe1, 0x78, 0x3a, 0x9e, 0xed, 0x46, 0x73, 0x34, 0x14, 0x44, 0x37, 0x37, 0x5a, 0xfc,
	0xe6, 0xbd, 0xbf, 0x16, 0xf0, 0x8a, 0x35, 0x74, 0xb3, 0x97, 0xee, 0x89, 0x9b, 0x0d, 0x15, 0x7c,
	0xf2, 0x27, 0x7f, 0xa5, 0x13, 0x6e, 0x75, 0x7e, 0x8f, 0x07, 0x7f, 0x68, 0x62, 0x45, 0x6f, 0x2d,
	0xf1, 0xc4, 0xf2, 0xd2, 0x3d, 0xba, 0xd1, 0x09, 0x3e, 0xf8, 0xdb, 0x26, 0xbb, 0xf0, 0xce, 0xd4,
	0x9b, 0xed, 0x46, 0x2f, 0x6e, 0x19, 0xa2, 0xdd, 0xed, 0x9b, 0x8a, 0x5d, 0x9e, 0x75, 0xa4, 0x6e,
	0x86, 0x9b, 0xad, 0xd4, 0xea, 0xcd, 0x7f, 0x7a, 0xfe, 0x51, 0xce, 0x29, 0xba, 0xf5, 0x76, 0xce,
	0x27, 0x7f, 0x06, 0xb7, 0x68, 0x77, 0xbf, 0xf0, 0x3e, 0xbe, 0xb6, 0xbc, 0x92, 0xd7, 0x84, 0x95,
	0x88, 0xcb, 0x12, 0x97, 0xc0, 0xba, 0x64, 0xdc, 0xa5, 0x12, 0x95, 0xfa, 0xc7, 0x5b, 0x79, 0xde,
	0x57, 0x5f, 0x47, 0xe3, 0xd3, 0x24, 0xf9, 0x36, 0x3a, 0x3c, 0x35, 0x92, 0x49, 0xa1, 0x90, 0x29,
	0xdb, 0x6a, 0x19, 0xa1, 0xd4, 0x21, 0xbf, 0x3b, 0xcc, 0x2a, 0x29, 0xd4, 0xaa, 0xc7, 0xac, 0x96,
	0xd1, 0xaa, 0xc7, 0xfc, 0x18, 0x1d, 0x99, 0x83, 0x38, 0x4e, 0x0a, 0x15, 0xc7, 0x3d, 0x2a, 0x8e,
	0x97, 0x51, 0x1c, 0xf7, 0xb8, 0xf3, 0xed, 0xce, 0xec, 0xe3, 0x5f, 0x01, 0x00, 0x00, 0xff, 0xff,
	0xab, 0x0f, 0x55, 0xb9, 0xd7, 0x03, 0x00, 0x00,
}
